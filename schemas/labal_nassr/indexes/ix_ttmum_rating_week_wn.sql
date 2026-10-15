-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labal_nassr.labal_nassr_rating_week USING btree (week_number);


--
