-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labkc_v1_bkp; Owner: -
--

CREATE INDEX ix_author_action_aid ON labkc_v1_bkp.labkc_v1_author_action USING btree (author_id);


--
