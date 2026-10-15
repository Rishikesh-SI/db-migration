-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labgmr_01082024; Owner: -
--

CREATE INDEX ix_author_action_aid ON labgmr_01082024.labgmr_author_action USING btree (author_id);


--
