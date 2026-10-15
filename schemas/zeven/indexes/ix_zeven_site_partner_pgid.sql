-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_site_partner_pgid
-- Type: INDEX

-- Name: ix_zeven_site_partner_pgid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_site_partner_pgid ON zeven.zeven_page_partner USING btree (page_id);


--
