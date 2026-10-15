-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: ix_unq_role_mid_aid_hi
-- Type: INDEX

-- Name: ix_unq_role_mid_aid_hi; Type: INDEX; Schema: labhkind; Owner: -
--

CREATE UNIQUE INDEX ix_unq_role_mid_aid_hi ON labhkind.labhkind_user_role_menu_action_map2 USING btree (role_id, user_menu_id, user_action_id);


--
