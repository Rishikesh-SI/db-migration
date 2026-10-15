-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labeisl; Owner: -
--

CREATE INDEX ix_author_action_aid ON labeisl.labeisl_author_action USING btree (author_id);


--
