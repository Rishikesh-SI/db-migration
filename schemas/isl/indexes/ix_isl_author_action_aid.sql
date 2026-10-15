-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_author_action_aid
-- Type: INDEX

-- Name: ix_isl_author_action_aid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_author_action_aid ON isl.isl_author_action USING btree (author_id);


--
