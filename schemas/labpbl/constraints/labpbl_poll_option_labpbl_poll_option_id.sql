-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_poll_option labpbl_poll_option_id
-- Type: CONSTRAINT

-- Name: labpbl_poll_option labpbl_poll_option_id; Type: CONSTRAINT; Schema: labpbl; Owner: -
--

ALTER TABLE ONLY labpbl.labpbl_poll_option
    ADD CONSTRAINT labpbl_poll_option_id PRIMARY KEY (poll_option_id);


--
