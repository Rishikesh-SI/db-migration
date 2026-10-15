-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labecn_bkp07062024; Owner: -
--

CREATE INDEX ix_author_action_aid ON labecn_bkp07062024.labecn_author_action USING btree (author_id);


--
