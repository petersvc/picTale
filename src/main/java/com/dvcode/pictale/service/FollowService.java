package com.dvcode.pictale.service;

import org.springframework.stereotype.Service;

import com.dvcode.pictale.model.Follow;
import com.dvcode.pictale.model.FollowId;
import com.dvcode.pictale.model.Photographer;
import com.dvcode.pictale.repository.FollowRepository;

@Service
public class FollowService {

    private final FollowRepository followRepository;

    public FollowService(FollowRepository followRepository) {
        this.followRepository = followRepository;
    }

    public boolean follow(Photographer follower, Photographer followee) {
        FollowId followId = new FollowId();
        followId.setFollowerId(follower.getId());
        followId.setFolloweeId(followee.getId());

        if (followRepository.existsById(followId)) {
            return false; // Já está seguindo
        }

        Follow follow = new Follow();
        follow.setId(followId);
        follow.setFollower(follower);
        follow.setFollowee(followee);

        followRepository.save(follow);
        return true;
    }
}
