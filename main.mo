import List "mo:base/List";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Int "mo:base/Int";

actor Election {

    // Seçmen türü
    type Voter = {
        id: Nat;
        name: Text;
        created_at: Int;
    };

    // Aday türü
    type Candidate = {
        id: Nat;
        name: Text;
        category: Text;
    };

    // Oy türü
    type Vote = {
        voter_id: Nat;
        candidate_id: Nat;
        category: Text;
        timestamp: Int;
    };

    stable var voters: List.List<Voter> = List.nil<Voter>();
    stable var candidates: List.List<Candidate> = List.nil<Candidate>();
    stable var votes: List.List<Vote> = List.nil<Vote>();

    // Benzersiz kimlik kontrolü
    private func is_unique_id(list: List.List<{id: Nat}>, id: Nat): Bool {
        return Option.isNone(List.find(list, func (item) { item.id == id }));
    };

    public func add_voter(id: Nat, name: Text, created_at: Int): async ?Voter {
        if (not is_unique_id(voters, id)) {
            return null;
        };
        let new_voter: Voter = { id; name; created_at };
        voters := List.push(new_voter, voters);
        return ?new_voter;
    };

    public func get_voters(): async List.List<Voter> {
        return voters;
    };

    public func get_voter_by_id(voter_id: Nat): async ?Voter {
        return List.find(voters, func (v: Voter) { v.id == voter_id });
    };

    public func add_candidate(id: Nat, name: Text, category: Text): async ?Candidate {
        if (not is_unique_id(candidates, id)) {
            return null;
        };
        let new_candidate: Candidate = { id; name; category };
        candidates := List.push(new_candidate, candidates);
        return ?new_candidate;
    };

    public func get_candidates(): async List.List<Candidate> {
        return candidates;
    };

    public func get_candidate_by_category(category: Text): async List.List<Candidate> {
        return List.filter(candidates, func (c: Candidate) { c.category == category });
    };

    public func commit_vote(voter_id: Nat, candidate_id: Nat, category: Text): async Bool {
        let is_eligible_voter = Option.isSome(await get_voter_by_id(voter_id));
        let has_not_voted = Option.isNull(List.find(votes, func (v: Vote) { v.voter_id == voter_id }));

        if (is_eligible_voter and has_not_voted) {
            let new_vote: Vote = {
                voter_id;
                candidate_id;
                category;
                timestamp = Int.now();
            };
            votes := List.push(new_vote, votes);
            return true;
        } else {
            return false;
        };
    };

    public func voting_results(): async List.List<{candidate_id: Nat; category: Text; votes: Nat}> {
        var results: List.List<{candidate_id: Nat; category: Text; votes: Nat}> = List.nil();

        for (candidate in candidates) {
            let count = List.size(List.filter(votes, func (v: Vote) {
                v.candidate_id == candidate.id and v.category == candidate.category
            }));
            results := List.push({candidate_id = candidate.id; category = candidate.category; votes = count}, results);
        };
        return results;
    };

    public func reset_votes(): async Bool {
        votes := List.nil();
        return true;
    };

    public func get_votes(): async List.List<Vote> {
        return votes;
    };

    public func update_vote(voter_id: Nat, candidate_id: Nat, category: Text): async Bool {
        let index = List.findIndex(votes, func (v: Vote) { v.voter_id == voter_id });
        if (Option.isSome(index)) {
            let new_vote: Vote = {
                voter_id;
                candidate_id;
                category;
                timestamp = Int.now();
            };
            votes := List.replace(votes, index.val, new_vote);
            return true;
        } else {
            return false;
        };
    };
}
