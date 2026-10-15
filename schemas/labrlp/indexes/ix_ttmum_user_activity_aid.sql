-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: ix_ttmum_user_activity_aid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aid; Type: INDEX; Schema: labrlp; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aid ON labrlp.labrlp_user_activity USING btree (user_id);


--
