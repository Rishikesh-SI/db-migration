-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_tmmimg_upd_web_user_clientid
-- Type: INDEX

-- Name: ix_tmmimg_upd_web_user_clientid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_tmmimg_upd_web_user_clientid ON tmmimg_upd.tmmimg_upd_web_user USING btree (upper_email_id, client_id);


--
