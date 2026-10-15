-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labfg; Owner: -
--

CREATE INDEX ix_author_action_aid ON labfg.labfg_author_action USING btree (author_id);


--
