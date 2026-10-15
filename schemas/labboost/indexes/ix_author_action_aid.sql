-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labboost; Owner: -
--

CREATE INDEX ix_author_action_aid ON labboost.labboost_author_action USING btree (author_id);


--
