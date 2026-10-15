-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_site_partner_pgid
-- Type: INDEX

-- Name: ix_dd_site_partner_pgid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_site_partner_pgid ON dd_30_04_24.dd_page_partner USING btree (page_id);


--
