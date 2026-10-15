-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_author_action_aid
-- Type: INDEX

-- Name: ix_mum_author_action_aid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_author_action_aid ON dhm.dhm_author_action USING btree (author_id);


--
