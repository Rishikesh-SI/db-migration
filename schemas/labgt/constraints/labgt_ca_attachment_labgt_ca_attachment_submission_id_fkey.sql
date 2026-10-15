-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_attachment labgt_ca_attachment_submission_id_fkey
-- Type: FK CONSTRAINT

-- Name: labgt_ca_attachment labgt_ca_attachment_submission_id_fkey; Type: FK CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_ca_attachment
    ADD CONSTRAINT labgt_ca_attachment_submission_id_fkey FOREIGN KEY (submission_id) REFERENCES labgt.labgt_ca_submission(id) ON DELETE CASCADE;


--
