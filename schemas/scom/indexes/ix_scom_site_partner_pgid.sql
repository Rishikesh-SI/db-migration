-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_site_partner_pgid
-- Type: INDEX

-- Name: ix_scom_site_partner_pgid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_site_partner_pgid ON scom.scom_page_partner USING btree (page_id);


--
