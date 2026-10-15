-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labgfg; Owner: -
--

CREATE INDEX ix_author_action_aid ON labgfg.labgfg_author_action USING btree (author_id);


--
