-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_site_partner_pgid
-- Type: INDEX

-- Name: ix_dd_site_partner_pgid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_site_partner_pgid ON dd.dd_page_partner USING btree (page_id);


--
