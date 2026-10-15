-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_tmmimg_upd_web_user_clientidsocid
-- Type: INDEX

-- Name: ix_tmmimg_upd_web_user_clientidsocid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_tmmimg_upd_web_user_clientidsocid ON tmmimg_upd.tmmimg_upd_web_user USING btree (social_id, client_id) WHERE (social_id IS NOT NULL);


--
