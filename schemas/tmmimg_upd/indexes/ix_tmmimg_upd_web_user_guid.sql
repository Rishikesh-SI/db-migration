-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_tmmimg_upd_web_user_guid
-- Type: INDEX

-- Name: ix_tmmimg_upd_web_user_guid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE UNIQUE INDEX ix_tmmimg_upd_web_user_guid ON tmmimg_upd.tmmimg_upd_web_user USING btree (user_guid);


--
