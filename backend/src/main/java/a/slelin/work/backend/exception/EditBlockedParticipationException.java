package a.slelin.work.backend.exception;

import lombok.Getter;

import java.util.UUID;

@Getter
public class EditBlockedParticipationException extends BusinessFault {

    private final UUID participationId;

    public EditBlockedParticipationException(UUID participationId) {
        super("Cannot change participation with id=%s, because it's blocked."
                .formatted(participationId.toString()));
        this.participationId = participationId;
    }

    public EditBlockedParticipationException(UUID participationId, String message) {
        super(message);
        this.participationId = participationId;
    }
}
