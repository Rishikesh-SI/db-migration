-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_author_action_aid
-- Type: INDEX

-- Name: ix_ppb_author_action_aid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_author_action_aid ON ppb.ppb_author_action USING btree (author_id);


--
