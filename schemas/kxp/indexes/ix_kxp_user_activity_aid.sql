-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_user_activity_aid
-- Type: INDEX

-- Name: ix_kxp_user_activity_aid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_user_activity_aid ON kxp.kxp_user_activity USING btree (user_id);


--
