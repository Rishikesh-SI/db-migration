-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_user_emailid
-- Type: INDEX

-- Name: ix_mum_user_emailid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_user_emailid ON tmmimg_upd.tmmimg_upd_user USING btree (email_id);


--
