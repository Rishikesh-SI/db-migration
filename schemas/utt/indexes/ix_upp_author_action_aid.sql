-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_author_action_aid
-- Type: INDEX

-- Name: ix_upp_author_action_aid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_author_action_aid ON utt.utt_author_action USING btree (author_id);


--
