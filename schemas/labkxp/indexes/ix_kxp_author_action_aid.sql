-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_author_action_aid
-- Type: INDEX

-- Name: ix_kxp_author_action_aid; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_author_action_aid ON labkxp.labkxp_author_action USING btree (author_id);


--
