-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_author_action pkl_author_action_id
-- Type: CONSTRAINT

-- Name: pkl_author_action pkl_author_action_id; Type: CONSTRAINT; Schema: pkl; Owner: -
--

ALTER TABLE ONLY pkl.pkl_author_action
    ADD CONSTRAINT pkl_author_action_id PRIMARY KEY (author_action_id);


--
