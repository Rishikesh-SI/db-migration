-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_author_action_aid ON tfa.tfa_author_action USING btree (author_id);


--
