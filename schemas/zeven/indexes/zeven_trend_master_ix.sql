-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_trend_master_ix
-- Type: INDEX

-- Name: zeven_trend_master_ix; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX zeven_trend_master_ix ON zeven.zeven_trend_master USING btree (articleid, asset_type_id, trend_type_id, is_latest);


--
