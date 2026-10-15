-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: ttmum; Owner: -
--

CREATE INDEX ix_author_action_aid ON ttmum.ttmum_author_action USING btree (author_id);


--
