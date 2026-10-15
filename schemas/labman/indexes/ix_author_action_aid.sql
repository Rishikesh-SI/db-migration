-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labman; Owner: -
--

CREATE INDEX ix_author_action_aid ON labman.labman_author_action USING btree (author_id);


--
