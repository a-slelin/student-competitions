package a.slelin.work.backend.data.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Builder;

@Builder
public record ReadStudentDto(@NotBlank String id,
                             String name,
                             String surname,
                             String middleName,
                             Long cardNumber,
                             String faculty,
                             String department,
                             String studyGroup,
                             String email,
                             String phone) implements ReadDto {
}
