-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_author_action_aid ON upy.upy_author_action USING btree (author_id);


--
