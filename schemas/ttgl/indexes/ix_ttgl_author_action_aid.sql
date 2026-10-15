-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_author_action_aid
-- Type: INDEX

-- Name: ix_ttgl_author_action_aid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_author_action_aid ON ttgl.ttgl_author_action USING btree (author_id);


--
