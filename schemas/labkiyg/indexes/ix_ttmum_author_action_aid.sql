-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: ix_ttmum_author_action_aid
-- Type: INDEX

-- Name: ix_ttmum_author_action_aid; Type: INDEX; Schema: labkiyg; Owner: -
--

CREATE INDEX ix_ttmum_author_action_aid ON labkiyg.labkiyg_author_action USING btree (author_id);


--
