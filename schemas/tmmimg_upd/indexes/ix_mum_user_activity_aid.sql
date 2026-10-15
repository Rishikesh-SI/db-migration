-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_user_activity_aid
-- Type: INDEX

-- Name: ix_mum_user_activity_aid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_user_activity_aid ON tmmimg_upd.tmmimg_upd_user_activity USING btree (user_id);


--
