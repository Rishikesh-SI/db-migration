-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_site_partner_pgid
-- Type: INDEX

-- Name: ix_pkl_site_partner_pgid; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_site_partner_pgid ON msl.msl_page_partner USING btree (page_id);


--
