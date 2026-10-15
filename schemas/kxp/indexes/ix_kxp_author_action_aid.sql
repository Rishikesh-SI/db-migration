-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_author_action_aid
-- Type: INDEX

-- Name: ix_kxp_author_action_aid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_author_action_aid ON kxp.kxp_author_action USING btree (author_id);


--
