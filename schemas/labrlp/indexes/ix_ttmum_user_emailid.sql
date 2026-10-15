-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labrlp; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labrlp.labrlp_user USING btree (email_id);


--
