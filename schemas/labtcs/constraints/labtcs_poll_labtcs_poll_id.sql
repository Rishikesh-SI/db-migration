-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_poll labtcs_poll_id
-- Type: CONSTRAINT

-- Name: labtcs_poll labtcs_poll_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_poll
    ADD CONSTRAINT labtcs_poll_id PRIMARY KEY (poll_id);


--
