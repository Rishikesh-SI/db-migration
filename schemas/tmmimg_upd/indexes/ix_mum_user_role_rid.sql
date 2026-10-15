-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_user_role_rid
-- Type: INDEX

-- Name: ix_mum_user_role_rid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_user_role_rid ON tmmimg_upd.tmmimg_upd_user_role USING btree (role_id);


--
