-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labpcm; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labpcm.labpcm_user USING btree (email_id);


--
