-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE INDEX ix_author_action_aid ON labecn_v1_bkp_29012025.labecn_v1_author_action USING btree (author_id);


--
