-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_rating_week_woty
-- Type: INDEX

-- Name: ix_mum_rating_week_woty; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_rating_week_woty ON tmmimg_upd.tmmimg_upd_rating_week USING btree (week_of_year);


--
