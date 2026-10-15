-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labbg; Owner: -
--

CREATE INDEX ix_author_action_aid ON labbg.labbg_author_action USING btree (author_id);


--
