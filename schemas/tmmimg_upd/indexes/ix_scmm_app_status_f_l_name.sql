-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_scmm_app_status_f_l_name
-- Type: INDEX

-- Name: ix_scmm_app_status_f_l_name; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_scmm_app_status_f_l_name ON tmmimg_upd.tmmimg_upd_app_status USING btree (upper((last_name)::text), upper((first_name)::text));


--
