-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: ix_ttmum_rating_week_woty
-- Type: INDEX

-- Name: ix_ttmum_rating_week_woty; Type: INDEX; Schema: labacko; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_woty ON labacko.labacko_rating_week USING btree (week_of_year);


--
