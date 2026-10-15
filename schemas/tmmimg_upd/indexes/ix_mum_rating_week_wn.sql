-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_rating_week_wn
-- Type: INDEX

-- Name: ix_mum_rating_week_wn; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_rating_week_wn ON tmmimg_upd.tmmimg_upd_rating_week USING btree (week_number);


--
