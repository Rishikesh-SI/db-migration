-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labsm; Owner: -
--

CREATE INDEX ix_author_action_aid ON labsm.labsm_author_action USING btree (author_id);


--
