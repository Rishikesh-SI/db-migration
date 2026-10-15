-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_poll labgrl_poll_id
-- Type: CONSTRAINT

-- Name: labgrl_poll labgrl_poll_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_poll
    ADD CONSTRAINT labgrl_poll_id PRIMARY KEY (poll_id);


--
