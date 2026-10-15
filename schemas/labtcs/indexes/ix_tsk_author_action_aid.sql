-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_author_action_aid
-- Type: INDEX

-- Name: ix_tsk_author_action_aid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_author_action_aid ON labtcs.labtcs_author_action USING btree (author_id);


--
