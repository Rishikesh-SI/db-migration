-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_rating_week_woty
-- Type: INDEX

-- Name: ix_ttmum_rating_week_woty; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_woty ON labisp.labisp_rating_week USING btree (week_of_year);


--
