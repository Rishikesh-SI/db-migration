-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_author_action labboost_author_action_id
-- Type: CONSTRAINT

-- Name: labboost_author_action labboost_author_action_id; Type: CONSTRAINT; Schema: labboost; Owner: -
--

ALTER TABLE ONLY labboost.labboost_author_action
    ADD CONSTRAINT labboost_author_action_id PRIMARY KEY (author_action_id);


--
